module QueryModule
  
  def query_usage
    return <<EOT
Generic query:
  --query
    Query a Newton soup.

EOT
  end

  def query_get_opts
    return [
      ["--query", GetoptLong::REQUIRED_ARGUMENT]
    ]
  end
  
  def query_handle_opts(opt, arg)
    case opt
    when "--query" then @cmd = "query"; @arg = arg
    end
  end

  def query_transition(state, action)
    case action.command
    when AppCmd::CONNECTED then
      @dock.receive(AppCmd.new(AppCmd::GET_STORE_NAMES))
    when AppCmd::STORE_NAMES then
      puts "Store names: \n#{action.data.to_s}"
      @newton_stores = action.data.to_ruby
      @dock.receive(AppCmd.new(AppCmd::SET_CURRENT_STORE, :default))
    when AppCmd::STORE_SELECTED then
      @dock.receive(AppCmd.new(AppCmd::GET_SOUP_NAMES))
    when AppCmd::SOUP_NAMES then
      puts "Soup names: \n#{action.data.to_s}"
      @dock.receive(AppCmd.new(AppCmd::SET_CURRENT_SOUP, @arg))
    when AppCmd::SOUP_SELECTED then
      @dock.receive(AppCmd.new(AppCmd::QUERY_SOUP, {
          :querySpec => {
          }
        }))
    when AppCmd::QUERY_CURSOR then
      @cursor = action.data
      @dock.receive(AppCmd.new(AppCmd::CURSOR_ENTRY, @cursor))
    when AppCmd::CURSOR_ENTRY then
      puts "Entry:\n#{action.data.to_ruby.to_yaml}"
      if not action.data.to_ruby
        @dock.receive(AppCmd.new(AppCmd::CURSOR_FREE, @cursor))
      else
        @dock.receive(AppCmd.new(AppCmd::CURSOR_NEXT, @cursor))
      end
    when AppCmd::CURSOR_FREED then
      @dock.receive(AppCmd.new(AppCmd::DISCONNECT))
    end
    return state
  end
  
end
