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
      this.send_post("/api/v1/users",
          {"user": {display_name, email, password, hometown}},
          (resp) => {
            this.fetch_user();
            store.dispatch({
              type: 'REGISTERED',
            });
          })
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
