class Router
  def initialize
    @routes = { 'GET' => [], 'POST' => [] }
  end

  def get(path, &block)
    add_route('GET', path, block)
  end

  def post(path, &block)
    add_route('POST', path, block)
  end

  def call(env)
    req = Rack::Request.new(env)
    method = req.request_method
    path = req.path_info

    @routes[method].each do |route|
      match = route[:pattern].match(path)
      if match
        if route[:param_name]
          param_value = match[1]
          req.update_param(route[:param_name].to_sym, param_value)
        end

        return build_response(200, { "Content-Type" => "text/html" }, [route[:block].call(req)])
      end
    end

    build_response(404, { "Content-Type" => "text/html" }, ["<h1>404 Not Found</h1>"])
  end

  private

  def add_route(method, path, block)
    if path.include?(":")
      param_name, pattern = compile_dynamic_route(path)
      @routes[method] << { pattern: pattern, param_name: param_name, block: block } 
    else
      pattern = Regexp.new("^#{Regexp.escape(path)}$")
      @routes[method] << { pattern: pattern, param_name: nil, block: block }
    end
  end

  def compile_dynamic_route(path)
    segments = path.split("/")
    param_index = segments.find_index { |p| p.start_with?(":") }
    param_name = segments[param_index][1..]
    segments[param_index] = "([^/]+)"
    pattern = Regexp.new("^#{segments.join('/')}$")
    [param_name, pattern]
  end

  def build_response(code, headers, body)
    [code, headers, body]
  end

end