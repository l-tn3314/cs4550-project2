import React from 'react';
import { Link } from 'react-router-dom';

function Notification(props) {
  // props.type, props.sender_displayname, props.from
  console.log(props);
  let {type, sender_displayname, from, closeCallback} = props

  let content;
  
  switch(type) {
    case 'FRIEND_REQUEST':
         content = <span><Link to={"/users/" + from}>{sender_displayname}</Link> send you a friend request!</span> 
      break;
    default:
      break;
  }

  return <div className="notif">
      {content}
      <span><button className="btn btn-secondary" onClick={closeCallback}>x</button></span>
    </div>;
}

export default Notification;

