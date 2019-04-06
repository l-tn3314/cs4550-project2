class TheServer {
  fetch_user(id, successCallback = (resp) => {}, errorCallback = (resp) => {}) {
    $.ajax("/api/v1/users/" + id, {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: (resp) => {
        console.log("success!")
        console.log(resp);
        successCallback(resp);
      },
      error: (resp) => {
        console.log("failed to fetch user " + id);
        console.log(resp);
        errorCallback(resp);
      },
    });
  }

  fetch_post(id, successCallback = (resp) => {}, errorCallback = (resp) => {}) {
    $.ajax("/api/v1/posts/" + id, {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: (resp) => {
        console.log("success!")
        console.log(resp);
        successCallback(resp);
      },
      error: (resp) => {
        console.log("failed to fetch post " + id);
        console.log(resp);
        errorCallback(resp);
      },
    });
  }
  
  // TODO token
  create_new_post(user_id, content, successCallback = (resp) => {}, errorCallback = (resp) => {}) {
    let current_time = new Date().toISOString();
    $.ajax("/api/v1/posts/", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({
        post: {
          user_id: user_id, 
          content: content,
          time: current_time,
        }
      }),
      success: (resp) => {
        successCallback(resp);
      },
      error: (resp) => {
        console.log("failed to create new post");
        console.log(resp);
        errorCallback(resp);
      }, 
    });
  }
  create_new_reply(user_id, post_id, content, successCallback = (resp) => {}, errorCallback = (resp) => {}) {
    let current_time = new Date().toISOString();
    $.ajax("/api/v1/replies/", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({
        reply: {
          user_id: user_id,
          post_id: post_id, 
          content: content,
          time: current_time,
        }
      }),
      success: (resp) => {
        successCallback(resp);
      },
      error: (resp) => {
        console.log("failed to create reply");
        console.log(resp);
        errorCallback(resp);
      }, 
    });
  }

  accept_friend_request(id, successCallback = (resp) => {}, errorCallback = (resp) => {}) {
    $.ajax("/api/v1/friendrequests/" + id, {
      method: "put",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: (resp) => {
        successCallback(resp);
      },
      error: (resp) => {
        console.log("failed to accept friend request");
        console.log(resp);
        errorCallback(resp);
      }, 
    });
  }

  send_friend_request(id, successCallback = (resp) => {}, errorCallback = (resp) => {}) {
    $.ajax("/api/v1/friendrequests/" + id, {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: (resp) => {
        successCallback(resp);
      },
      error: (resp) => {
        console.log("failed to send friend request");
        console.log(resp);
        errorCallback(resp);
      }, 
    });
  }

  register_user(display_name, email, password, hometown) {
     $.ajax("/api/v1/users", {
         method: "post",
         dataType: "json",
         contentType: "application/json; charset=UTF-8",
         data: {"user": {display_name, email, password, hometown}},
         success:
          (resp) => {
            this.fetch_user();
            store.dispatch({
              type: 'REGISTERED',
            });
          },
         error: (resp) => {
             this.fetch_user();
             store.dispatch({
                 type: "REGISTER_ERROR",
             });
         }
     });
  }

  create_session(display_name, email, password, hometown) {
    this.send_post(
      "/api/v1/auth",
      {display_name, email, password, hometown},
      (resp) => {
        localStorage["project2_session"] = JSON.stringify(resp.data);
        store.dispatch({
          type: 'NEW_SESSION',
          data: resp.data,
        });
      },
      (resp) => {
        store.dispatch({
          type: 'LOGIN_ERROR',
        });
      }
    );
  }

  destroy_session() {
    delete localStorage["project2_session"];
    store.dispatch({
      type: 'DESTROY_SESSION'
    });
  }

}

export default new TheServer();
