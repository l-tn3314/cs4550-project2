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
}

export default new TheServer();
