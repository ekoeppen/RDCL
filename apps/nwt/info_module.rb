module InfoModule
  
  attr_accessor :info_current_store

  def info_usage
    return <<EOT
  Info:
    --info, -n
      return information about the connected device.
  
EOT
  end

  def info_get_opts
    return [
      ["--info", "-n", GetoptLong::NO_ARGUMENT]
    ]
  end
  
  def info_handle_opts(opt, arg)
    case opt
    when "--info" then @cmd = "info"
    end
  end
  
  def info_transition(state, action)
    case action.command
    when AppCmd::CONNECTED then
      log "Getting device information."
      @dock.receive(AppCmd.new(AppCmd::GET_STORE_NAMES))
    when AppCmd::STORE_NAMES then
      puts "Store names: \n#{action.data.to_s}"
      @newton_stores = action.data.to_ruby
      @info_current_store = 0
      @dock.receive(AppCmd.new(AppCmd::SET_CURRENT_STORE, @newton_stores[@info_current_store]))
    when AppCmd::STORE_SELECTED then
      puts "Store #{@newton_stores[@info_current_store][:name]} selected."
      @dock.receive(AppCmd.new(AppCmd::GET_SOUP_NAMES))
    when AppCmd::SOUP_NAMES then
      puts "Soup names: \n#{action.data.to_s}"
      @info_current_store += 1
      if @info_current_store < @newton_stores.length
        @dock.receive(AppCmd.new(AppCmd::SET_CURRENT_STORE, @newton_stores[@info_current_store]))
      else
        @dock.receive(AppCmd.new(AppCmd::GET_APP_LIST))
      end
    when AppCmd::APP_LIST then
      puts "Applications: \n#{action.data.to_s}"
      @dock.receive(AppCmd.new(AppCmd::DISCONNECT))
    end
    return state
  end
  
end
