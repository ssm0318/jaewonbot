class BasicController < ApplicationController
    def new_friend
        Log.create(user_key: params[:user_key], message: "new friend")
        msg = {}
        render json: msg, status: :ok
    end

    def deleted_friend
        Log.create(user_key: params[:user_key], message: "deleted friend")
        msg = {}
        render json: msg, status: :ok
    end

    def left_chat
        Log.create(user_key: params[:user_key], message: "left chatroom")
        msg = {}
        render json: msg, status: :ok
    end

    def keyboard_init
        @msg = 
            {
                type: "buttons",
                buttons: ["재원봇 안녕!!"]
            }
        render json: @msg, status: :ok
    end

    def chat_control
        @response = params[:content]
        @user_key = params[:user_key]
        @user = User.find_or_create_by(user_key: @user_key)
        @convo_type = @user.responses.last.content_type
        Chat.create(user_id: @user.id, content: @response)

        if @convo_type == nil
            if @user.name == nil
                my_response = "처음 뵙겠습니다! 당신의 이름이 무엇인가요? (닉네임을 적어주셔도 좋습니다.)"
                @response = {
                    message: {
                        text: my_response
                    },
                    keyboard: {
                        type: "text"
                    }
                }
                Response.create(content: my_response, content_type: "new user")
                render json: @response, status: :ok
            else
                my_response = "#{@user.name}님, 안녕하세요! 또 뵙네요!\n무엇을 도와드릴까요?\n(언제든지 \"ㅈㅇㅂ\"을 입력해 저를 소환하실 수 있어요!)"
                @response = {
                  message: {
                      text: my_response
                  },
                  keyboard: {
                    type: "buttons",
                    buttons: ["격식 있는 대화", "캐치마인드", "타로점/운세", "아만다", "TMI 대잔치", "기타/설정"]
                  }
                }
                Response.create(content: my_response, content_type: "basic_options")
                render json: @response, status: :ok    
            end
        elsif @convo_type = "new user"
            @user = User.create(name: @response, user_key: @user_key)
            my_response = "#{@user.name}님 반갑습니다! 무엇을 도와드릴까요?\n(언제든지 \"ㅈㅇㅂ\"을 입력해 저를 소환하실 수 있어요!)"
            @response = {
                message: {
                    text: my_response
                },
                keyboard: {
                    type: "buttons",
                    buttons: ["격식 있는 대화", "캐치마인드", "타로점/운세", "아만다", "TMI 대잔치", "기타/설정"]
                }
            }
            Response.create(content: my_response, content_type: "basic_options")
            render json: @response, status: :ok
        elsif @response == "ㅈㅇㅂ"
            my_response = "예이~ 메뉴 대령이오~!"
            @response = {
                message: {
                    text: my_response
                },
                keyboard: {
                  type: "buttons",
                  buttons: ["격식 있는 대화", "캐치마인드", "타로점/운세", "아만다", "TMI 대잔치", "기타/설정"]
                }
            }
            Response.create(content: my_response, content_type: "basic_options")
            render json: @response, status: :ok
        elsif @convo_type = "basic_options"
            if @response == "격식 있는 대화"
                
            elsif @response == "캐치마인드"
            elsif @response == "캐치마인드"
            elsif @response == "캐치마인드"
            elsif @response == "캐치마인드"
            elsif @response == "캐치마인드"
            end
        end
    end
end
