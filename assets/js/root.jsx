import React from 'react';
import ReactDOM from 'react-dom';
import { Link, BrowserRouter as Router, Route } from 'react-router-dom';
import _ from 'lodash';
import $ from 'jquery';

import Post from './Post';
import UserProfile from './UserProfile';
import RegisterForm from './RegisterForm';
import EditUserForm from './EditUserForm';

export default function root_init(node) {
    let element = (
        <div>
          <h1>Hello, world!</h1>
          <h2>It is {new Date().toLocaleTimeString()}.</h2>
        </div>
    );
    ReactDOM.render(<Root  />, node);
}

class Root extends React.Component {
    constructor(props) {
        super(props);
        let session = null;
        if( localStorage["project2_session"]) {
            session = JSON.parse( localStorage["project2_session"]);
        }
        this.state = {
            login_form: {email: "", password: ""},
            session: session,
            error: null,
            users: [],
        };
        this.fetch_users();
    }

    update_login_form(data) {
        let form1 = _.assign({}, this.state.login_form, data);
        let state1 = _.assign({}, this.state, { login_form: form1 });
        this.setState(state1);
    }

    login() {
        $.ajax("/api/v1/auth", {
            method: "post",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify(this.state.login_form),
            success: (resp) => {
                localStorage["project2_session"] = JSON.stringify(resp.data);
                let state1 = _.assign({}, this.state, { session: resp.data, error: null });
                this.setState(state1);
            },
            error: (resp) => {
                let state1 = _.assign({}, this.state, { error: "Login failed"});
                this.setState(state1);
            }
        });
    }

    logout() {
        delete localStorage["project2_session"];
        let state1 = _.assign({}, this.state, {session:null});
        this.setState(state1);
    }

    render() {
      return <Router>
        <div>
          <Header session={this.state.session} root={this} />
          <Route path="/users" exact={true} render={() =>
            <UserList users={this.state.users} />
          } />
          <Route path="/users/:id" render={(props) => 
            <UserProfile {...props} session={this.state.session} />
          } />
          <Route path="/posts/:id" render={(props) =>
            <Post {...props} session={this.state.session} />
          } />
          <Route path="/register" component={RegisterForm} />
          <Route path="/edituser" render={() =>
                  <EditUserForm logout={this.logout.bind(this)} user_id={this.state.session && this.state.session.user_id || 0} />
          } />

        </div>
      </Router>;
    }

    fetch_users() {
        $.ajax("/api/v1/users", {
            method: "get",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: "",
            success: (resp) => {
                let state1 = _.assign({}, this.state, { users: resp.data });
                this.setState(state1);
            }
        });
    }
}

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
            <br/>
            {root.state.error || ""}
            </form>
            </div>;
    } else {
        session_info = <div className="my-2">
            <p>Logged in as {session.display_name}</p>
            <Link to={"/edituser"}>Edit Profile</Link><br/>
            <button className="btn btn-secondary" onClick={() => root.logout()}>Log Out</button>
            </div>
    }

    let register_link = [];
    if (session == null) {
        register_link = <Link to={"/register"}>Register</Link>;
    }

    return <div className="row my-2">
        <div className="col-4">
            <Link to={"/"}><h1>Project2</h1></Link>
        </div>
        <div className="col-4">
        <p>
        <Link to={"/users"}>Users</Link>
        &nbsp;
        {register_link}
        </p>
        </div>
        <div className="col-4">
        {session_info}
        </div>
        </div>;
}

function UserList(props) {
      let rows = _.map(props.users, (uu) => <User key={uu.id} user={uu} />);
      return <div className="row">
            <div className="col-12">
              <table className="table table-striped">
                <thead>
                  <tr>
                    <th>email</th>
                    <th>display name</th>
                  </tr>
                </thead>
                <tbody>
                  {rows}
            </tbody>
              </table>
            </div>
          </div>;
}

function User(props) {
      let {user} = props;
      return <tr>
            <td>{user.email}</td>
            <td>{user.display_name}</td>
          </tr>;
}
