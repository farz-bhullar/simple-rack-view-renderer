require 'erb'
require_relative './router'

class Application
  def self.router
    router = Router.new

    router.get("/") do |req|
      render("home", title: "Welcome to Simple Rack Router")
    end

    router.get("/about") do |req|
      render("about", title: "About Page")
    end

    router.get("/users/:id") do |req|
      id = req.params[:id]
      render("user", title: "User Page", id: id)
    end

    router
  end

  def self.render(view_name, locals = {})
    view_path = File.join(__dir__, "views", "#{view_name}.erb")
    template = ERB.new(File.read(view_path))

    context = Struct.new(*locals.keys).new(*locals.values)
    template.result(context.instance_eval { binding })
  end
end