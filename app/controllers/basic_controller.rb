class BasicController < ApplicationController
    def keyboard_init
        @msg = 
            {
                type: "buttons",
                buttons: ["안녕하세요!"]
            }
        render json: @msg, status: :ok
    end

    def chat_control
        @response = params[:content]
        @user_key = params[:user_key]
        @user = User.find_or_create_by(user_key: @user_key)

        
        if @user.name == nil
            if @response == "안녕하세요!"
                @response = {
                    message: {
                        text: "처음 뵙겠습니다! 당신의 이름이 무엇인가요? (닉네임을 적어주셔도 좋습니다.)"
                    },
                    keyboard: {
                        type: "text"
                    }
                }
                render json: @response, status: :ok
            else
                @user.name = @response
                @user.user_key = @user_key
                @user.save
                @response = {
                    message: {
                        text: "#{@user.name}님 환영합니다!"
                    },
                    keyboard: {
                        type: "text"
                    }
                }
                render json: @response, status: :ok
            end
        else
            if @response == "안녕하세요!"
                @response = {
                  message: {
                      text: "#{@user.name}님, 안녕하세요!"
                  },
                  keyboard: {
                    type: "text"
                  }
                }
                render json: @response, status: :ok
            else
                response_choices = ["뀨뀨꺄꺄!!!!", "뀨?", "데헷", "밍...", "낄낄낄", ">_<", "호이호이호잇 @_@", "웬열~~~", "으휴~~ 바보~~", "ㅗ", "^ㅗ^", "머라구~~?!", "화나떠??!?", "뿌잉뿌잉 ><"]
                if(rand(1...8) % 3 != 0)
                    msg = response_choices.sample
                else
                    msg = @response
                end
                @response = {
                  message: {
                      text: msg
                  },
                  keyboard: {
                    type: "text"
                  }
                }
                render json: @response, status: :ok
            end            
        end
    end
end
