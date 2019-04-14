import React from 'react';
import { Link } from 'react-router-dom';
import _ from 'lodash';

import api from './api';

class UserNotifications extends React.Component {
  constructor(props) {
    super(props);

    /*
      list of:
      {
        actor_id
        actor_displayname
        ent_id
        type
      }
    */
    this.state = {
      notifs: null
    }; 
  
  }

  componentDidMount() {
    if (this.props.session) {
      api.fetch_notifs(this.props.session.token, this.props.session.user_id, this.updateState.bind(this));
    }    
  }

  updateState(state) {
    this.setState({notifs: state.data});
  }

  renderNotif(notif) {
    switch(notif.type) {
      case "friend_accept":
        return <tr key={notif.id}><td><Link to={"/users/" + notif.actor_id}>{notif.actor_displayname}</Link> accepted your friend request, poke them now!</td></tr>
      case "friend_request":
        return <tr key={notif.id}><td><Link to={"/users/" + notif.actor_id}>{notif.actor_displayname}</Link> sent you a friend request!</td></tr>
      case "poke":
        return <tr key={notif.id}><td><Link to={"/users/" + notif.actor_id}>{notif.actor_displayname}</Link> poked you!</td></tr>
      case "reply":
        return <tr key={notif.id}><td><Link to={"/users/" + notif.actor_id}>{notif.actor_displayname}</Link> replied to your <Link to={"/posts/" + notif.ent_id}>post</Link></td></tr>
      default:
        return null;
    }
  }

  render() {

    let rows = this.state.notifs
        ? _.map(this.state.notifs, this.renderNotif)
        : <tr><td><p>Loading...</p></td></tr>;
    
    return !this.props.session
        ? <div><h3>Log in to view your notifications</h3></div>
        : <div className="row">
            <div className="col-12">
              <table className="table table-striped">
                <thead>
                  <tr><th>My Notifications</th></tr>
                </thead>
                  <tbody>
                    {rows}
                </tbody>
              </table>
            </div>
          </div>;
      
  }
}

export default UserNotifications
