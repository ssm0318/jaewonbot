User.create(name: "yulo")
User.create(name: "jaewon")
User.create(name: "jane")

Chat.create(user_id: 1, content: "hello")
Chat.create(user_id: 1, content: "bye")
Chat.create(user_id: 2, content: "steve")

Response.create(user_id: 1, content: "hi", content_type: "random")
Response.create(user_id: 1, content: "BIBI", content_type: "hmmm")
Response.create(user_id: 1, content: "bo", content_type: "random")
Response.create(user_id: 2, content: "oh", content_type: "wow")
Response.create(user_id: 1, content: "huh", content_type: "random")
