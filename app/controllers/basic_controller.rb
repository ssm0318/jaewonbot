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
                        text: "#{@user.name}님 반갑습니다! 무엇을 도와드릴까요?\n(언제든지 \"ㅈㅇㅂ\"을 입력해 저를 소환하실 수 있어요!)"
                    },
                    keyboard: {
                        type: "buttons",
                        buttons: ["심심해", "너는 뭐하는 애야?", "하고 싶은 말이 있어", "TMI 대잔치"]
                    }
                }
                render json: @response, status: :ok
            end
        else
            if @user.id != 1
                Chat.create(user_id: @user.id, content: @response)
            end
            if  @response == "재원봇 안녕!!"
                @response = {
                  message: {
                      text: "#{@user.name}님, 안녕하세요! 또 뵙네요!\n무엇을 도와드릴까요?\n(언제든지 \"ㅈㅇㅂ\"을 입력해 저를 소환하실 수 있어요!)"
                  },
                  keyboard: {
                    type: "buttons",
                    buttons: ["심심해", "너는 뭐하는 애야?", "하고 싶은 말이 있어", "TMI 대잔치"]
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
            elsif @response == "ㅈㅇㅂ"
                @response = {
                    message: {
                        text: "네!!!"
                    },
                    keyboard: {
                      type: "buttons",
                      buttons: ["심심해", "너는 뭐하는 애야?", "하고 싶은 말이 있어", "TMI 대잔치"]
                    }
                  }
                  render json: @response, status: :ok
            elsif @response == "너는 뭐하는 애야?"
                @response = {
                    message: {
                        text: "저에 대해 궁금해해주셔서 감사합니다!\n저는 [재원]이 느릿느릿 준비하고 있는 <공공재원>이라는 서비스를 돕기 위해 다시 태어날 재원봇이예요!"
                    },
                    keyboard: {
                      type: "text"
                    }
                  }
                  render json: @response, status: :ok
            elsif @response == "심심해"
                @response = {
                    message: {
                        text: "야~ 나랑 놀자~ 어디 가지 말고~"
                    },
                    keyboard: {
                        type: "text"
                    }
                }
                render json: @response, status: :ok
            elsif @response == "하고 싶은 말이 있어"
                @response = {
                    message: {
                        text: "얼마든지 말씀해주세요!\n제가 쪼꼼 멍청하다고 느껴지시면 [재원]을 찾아주세요!\n[재원]은 주로 [집]에 서식하고 언제나 당신의 이야기를 들을 준비가 되어있대요!"
                    },
                    keyboard: {
                        type: "text"
                    }
                }
                render json: @response, status: :ok
            elsif @response == "TMI 대잔치"
                responses = ["제 프로필 사진을 누르면 쿠폰을 발급 받으실 수 있어요!", "[김무성]의 최애 꽃은 수국이예요.", "[박근혜] 화보집 양장본은 49,000원이예요.",
                            "[홍준표]는 눈썹문신을 했어요.", "우리는 평균 6개월을 신호 기다리는 데에 써요.", "코를 고는 동시에 꿈을 꿀 수 없대요 (믿거나 말거나)", "[김정은]은 치즈 덕후예요.",
                            "모리돈부리 텐동은 매우 짜요. 소스를 적게 뿌려달라고 하세요.", "저는 안닦파예요", "[안철수]는 차차틴트를 써요.", "[이명박]의 허리는 32인치예요.", "[트럼프]는 키스데이에 태어났어요.",
                            "[스윙스]는 키스미 마스카라를 사용해요.", "[신동엽]은 유두피어싱을 했어요.", "[반기문]은 가을 웜톤이예요.", "[김종민]은 브라질리언 왁싱을 했어요.",
                            "[이명박]은 겨울쿨톤이예요.", "[김제동]은 혀로 쳉리꼭지를 묶을 수 있어요.", "[박근혜]는 올레티비를 시청해요.", "[이명박]의 월 이발 횟수는 [2회]예요."]
                @response = {
                    message: {
                        text: responses.sample
                    },
                    keyboard: {
                        type: "text"
                    }
                }
                render json: @response, status: :ok
            else
                response_choices = ["뀨뀨꺄꺄!!!!", "뀨?", "데헷 >_<", "밍...", "호이호이호잇 @_@", "웬열~~~", "으휴~~ 바보~~", "ㅗ", "^ㅗ^", "머라구~~?!", "화나떠??!?", "즐~", "뿌잉뿌잉",
                                    "얼씨구~", "풉", "ㅋ", "헿헿", "까까꾸꾸?", "기싱꿍꼬또", "까까꾹ㄱ끄끆ㄲ꺄꺄끾ㄲ", "뿡!", "아휴 냄새~~", "꿹뒓붽쉜뷁뷁뛟", "<3", "모해?"]
                key = rand(1...9)
                if(key % 5 == 0)
                    msg = @response
                elsif(key % 6 == 0)
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
