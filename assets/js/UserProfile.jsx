import React from 'react';

import api from './api';

// TODO make this a function after adding store...?
class UserProfile extends React.Component {
  constructor(props) {
    super(props);

    this.user_id = props.match.params.id;
  
    this.state = {
      display_name: "loading"
    }; 

    this.fetchUser();  
  }

  fetchUser() {
    console.log("fetch user");
    api.fetch_user(this.user_id, this.updateState.bind(this));
  }

  updateState(state) {
    this.setState(state);
  }

  acceptFriendRequest() {
    api.accept_friend_request(this.user_id, this.fetchUser.bind(this));
  }

  sendFriendRequest() {
    api.send_friend_request(this.user_id, this.fetchUser.bind(this));
  }

  render() {
    let friendStatus; 
    
    if (this.state.is_friend) {
      friendStatus = <p>Friends! :)</p>
    } else if (this.state.sent_request_to) {
      friendStatus = <p>Waiting for friend request to be accepted...</p>
    } else if (this.state.has_request_from) {
      friendStatus = <button className="btn btn-primary" onClick={this.acceptFriendRequest.bind(this)}>Accept friend request!</button>
    } else {
      friendStatus = <button className="btn btn-secondary" onClick={this.sendFriendRequest.bind(this)}>Send friend request</button>
    }

    return <div>
        <h2>{this.state.display_name}</h2>
        {friendStatus}
      </div>;
  }
    
}

export default UserProfile;
