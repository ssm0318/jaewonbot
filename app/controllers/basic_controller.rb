class BasicController < ApplicationController
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

        if @user.name == nil
            if @response == "재원봇 안녕!!"
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
                        text: "#{@user.name}님 반갑습니다!\n무엇을 도와드릴까요?"
                    },
                    keyboard: {
                        type: "button"
                        buttons: ["심심해", "너는 뭐하는 애야?", "하고 싶은 말이 있어"]
                    }
                }
                render json: @response, status: :ok
            end
        else
            Chat.create(user_id: @user.id, content: @response)
            if  @response == "재원봇 안녕!!"
                @response = {
                  message: {
                      text: "#{@user.name}님, 안녕하세요! 또 뵙네요!"
                  },
                  keyboard: {
                    type: "text"
                  }
                }
                render json: @response, status: :ok
            elsif ["ㅎㅇ", "안녕", "hi", "hello", '하이', "안녕?", "안녕하세요!", "안녕하세요?", "안녕하세요", "ㅎㅇㅎㅇ"].include? @response
                @response = {
                    message: {
                        text: "안녕하세요, #{@user.name}님!!"
                    },
                    keyboard: {
                      type: "text"
                    }
                  }
                  render json: @response, status: :ok
            elsif @response == "재원봇"
                @response = {
                    message: {
                        text: "네!!!"
                    },
                    keyboard: {
                      type: "button"
                      buttons: ["심심해", "너는 뭐하는 애야?", "하고 싶은 말이 있어"]
                    }
                  }
                  render json: @response, status: :ok
            elsif @response == "너는 뭐하는 애야?"
                @response = {
                    message: {
                        text: "저에 대해 궁금해해주셔서 감사합니다! 저는 곧 <공공재원>이라는 서비스를 돕기 위해 다시 태어날 재원봇이예요! \"재원봇\"을 입력해 언제든 저를 소환해주세요!"
                    },
                    keyboard: {
                      type: "text"
                    }
                  }
                  render json: @response, status: :ok
            elsif @response == "하고 싶은 말이 있어"
                @response = {
                    message: {
                        text: "얼마든지 말해주세요! 제가 쪼꼼 멍청하다고 느껴지시면 [재원]을 찾아주세요! [재원]은 주로 [집]에 서식하고 언제나 당신의 이야기를 들을 준비가 되어있대요!"
                    },
                    keyboard: {
                        type: "text"
                    }
                    render json: @response, status: :ok
            else
                response_choices = ["뀨뀨꺄꺄!!!!", "뀨?", "데헷 >_<", "밍...", "호이호이호잇 @_@", "웬열~~~", "으휴~~ 바보~~", "ㅗ", "^ㅗ^", "머라구~~?!", "화나떠??!?", "즐~", "뿌잉뿌잉",
                                    "얼씨구~", "풉", "ㅋ", "헿헿", "까까꾸꾸?", "기싱꿍꼬또", "까까꾹ㄱ끄끆ㄲ꺄꺄끾ㄲ", "뿡!", "아휴 냄새~~", "꿹뒓붽쉜뷁뷁뛟", "<3", "모해?"]
                key = rand(1...9)
                if(key % 5 == 0)
                    msg = @response
                elsif(key % 3 == 0)
                    msg = "#{@user.name} 바보"
                else
                    msg = response_choices.sample
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
