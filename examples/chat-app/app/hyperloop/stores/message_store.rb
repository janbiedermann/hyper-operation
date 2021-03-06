class MessageStore < Hyperloop::Store
  state :messages, scope: :class, reader: :all
  state :user_name, scope: :class, reader: true

  def self.online?
    state.messages
  end

  receives Operations::Join do |params|
    puts "receiving Operations::Join(#{params})"
    mutate.user_name params.user_name
  end

  receives Operations::GetMessages do |params|
    puts "receiving Operations::GetMessages(#{params})"
    mutate.messages params.messages
  end

  receives Operations::Send do |params|
    puts "receiving Operations::Send(#{params})"
    mutate.messages << params.message
  end
end
