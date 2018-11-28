class User < ApplicationRecord
    has_many    :chats
    has_many    :responses
end
