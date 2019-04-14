import React from 'react';
import { Link } from 'react-router-dom';

function Header(props) {
    let {root, session} = props;
    let session_info;
    if (session == null) {
        session_info = <div className="form-inline my-2">
            <form action="javascript:void(0)" onSubmit={() => root.login()}>
            <input type="email" placeholder="email"
        onChange={(ev) => root.update_login_form({email: ev.target.value})} />
            <input type="password" placeholder="password"
        onChange={(ev) => root.update_login_form({password: ev.target.value})} />
            <button className="btn btn-secondary" type="submit">Login</button>
            <Link className="ml-5" to={"/register"}>Register</Link>
            <br/>
            {root.state.error || ""}
            </form>
            </div>;
    } else {
        let date = new Date().toLocaleTimeString();
        session_info = <div className="my-2">
              <div>
                <p>
                  <font color="yellow">Logged in as </font><Link to={"/users/" + session.user_id}>{session.display_name}</Link>
                <button className="ml-5 btn btn-secondary btn-sm" onClick={() => root.logout()}>Log Out</button>
                </p>
                <font color="grey"><strong>At</strong>: </font> {date}
              </div>
              <Link to={"/edituser"}>Edit Profile</Link>
            </div>;
    }
  
    let myNotifs = session == null
      ? null
      : <span className="header-notifs"><Link to={"/notifications"}>My Notifications</Link></span>

    return <div className="row my-2">
        <div className="col-4">
            <Link to={"/"}><h2>Pokester</h2></Link>
        </div>
        <div className="col-4">
            <p>
              <Link to={"/users"}>Users</Link>
              {myNotifs}
            </p>
        </div>
        <div className="col-4">
            {session_info}
        </div>
      </div>;
}

export default Header;
