import React from 'react';
import { Link } from 'react-router-dom';

function Notification(props) {
  // props.type, props.sender_displayname, props.from
  console.log(props);

  let content;
  
  switch(props.type) {
    case 'FRIEND_REQUEST':
         content = <span><Link to={"/users/" + props.from}>{props.sender_displayname}</Link> send you a friend request!</span> 
      break;
    default:
      break;
  }

  return <div>
      {content}
    </div>;
}

export default Notification;

