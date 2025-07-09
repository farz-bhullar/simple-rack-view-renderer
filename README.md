# rack-view-renderer

🧩 A minimal Rack app that renders HTML views using ERB — no Rails, no Sinatra.

## ✨ Features

- ✅ ERB view rendering
- ✅ Route-to-view mapping
- ✅ Dynamic variables in templates

## 🔧 Getting Started

### 1. Install Rack

`gem install rack`

### 2. Run the server

`rackup config.ru`

### 3. Try it out

- [http://localhost:9292](http://localhost:9292)
- [http://localhost:9292/users/123](http://localhost:9292/users/123)
- [http://localhost:9292/about](http://localhost:9292/about)

Visit the above URLs in your browser to see the router in action.

## 🧠 Purpose

To understand how view rendering works in Ruby web frameworks by building a minimal ERB renderer on top of Rack.