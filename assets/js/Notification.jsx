import React from 'react';
import { Link } from 'react-router-dom';

function Notification(props) {
  // props.type, props.sender_displayname, props.from
  console.log(props);
  let {type, sender_displayname, from, closeCallback, recipient_displayname, msg} = props

  let content;
  
  switch(type) {
    case 'FRIEND_REQUEST':
      content = <span><Link to={"/users/" + from}>{sender_displayname}</Link> sent you a friend request!</span> 
      break;
    case 'FRIEND_ACCEPT':
      content = <span><Link to={"/users/" + from}>{sender_displayname}</Link> accepted your friend request!</span> 
      break;
    case 'POKE':
      content = <span><Link to={"/users/" + from}>{sender_displayname}</Link> poked you!</span> 
      break;
    case 'POKE_SUCCESS':
      content = <span>Poke to <i>{recipient_displayname}</i> was successful!</span>
      break;
    case 'POKE_FAIL':
      content = <span>Poke to <i>{recipient_displayname}</i> failed... {msg}</span>
      break;
    default:
      content = <span>Easter egg ;)</span>
      break;
  }

  return <div className="notif">
      {content}
      <span><button className="ml-5 btn btn-secondary btn-sm" onClick={closeCallback}>x</button></span>
    </div>;
}

export default Notification;

