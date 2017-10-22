    import "phoenix_html"
    import {Socket, Presence} from "phoenix"

    // Socket
    let user = document.getElementById("User").innerText // hello
    let socket = new Socket("/socket", {params: {user: user}})
    socket.connect()

    // Presence
    let presences = {}

    let formatTimestamp = (timestamp) => {
      let date = new Date(timestamp)
      return date.toLocaleTimeString()
    }
    let listBy = (user, {metas: metas}) => {
      return {
        user: user,
        onlineAt: formatTimestamp(metas[0].online_at)
      }
    }

    let userList = document.getElementById("UserList")
    let render = (presences) => {
        console.log(presences);

      userList.innerHTML = Presence.list(presences, listBy)
        .map(presence => `
          <li>
            <b>${presence.user}</b>
          </li>
        `)
        .join("")
    }

    // Channels
    let chat = socket.channel("search:chat", {})
    let ai = socket.channel("search:ai", {})
    console.log("Joined ai channel")


    ai.on("shout", paylaod => {
      console.log('shout',paylaod)
    })

    chat.on("presence_state", state => {
        console.log('presence_state',state);
      presences = Presence.syncState(presences, state)
      render(presences)
    })

    chat.on("presence_diff", diff => {
        console.log("presence_diff", diff);
      presences = Presence.syncDiff(presences, diff)
      render(presences)
    })

    chat.join()

    // Chat
    window.onload = function() {
        let messageInput = document.getElementById("NewMessage");
        messageInput.addEventListener("keypress", (e) => {
          if (e.keyCode == 13 && messageInput.value != "") {
             var user = document.getElementById("UserData").innerText;

            chat.push("message:new", messageInput.value + '§' + user);

            messageInput.value = "";
          }
      });
    };

    let messageList = document.getElementById("MessageList")
    let renderMessage = (message) => {
        var res = message.body.split('§');

        console.log('MessageList', res);

        $('#MessageList').append('<p><small style="color:black;font-size:10px">'+res[1]+'</small><br />'+res[0]  +'</p>');
    }

    chat.on("message:new", message => renderMessage(message))
