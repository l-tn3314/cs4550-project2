import React from 'react';
import ReactDOM from 'react-dom';
import { Link, BrowserRouter as Router, Route } from 'react-router-dom';
import _ from 'lodash';
import $ from 'jquery';

import UserProfile from './UserProfile';

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
        this.state = {
            login_form: {email: "", password: ""},
            session: null,
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
                let state1 = _.assign({}, this.state, { session: resp.data });
                this.setState(state1);
            }
        });
    }

    render() {
      return <Router>
        <div>
          <Header session={this.state.session} root={this} />
          <Route path="/users" exact={true} render={() =>
            <UserList users={this.state.users} />
          } />
          <Route path="/users/:id" component={UserProfile} />
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
            <input type="email" placeholder="email"
        onChange={(ev) => root.update_login_form({email: ev.target.value})} />
            <input type="password" placeholder="password"
        onChange={(ev) => root.update_login_form({password: ev.target.value})} />
            <button className="btn btn-secondary" onClick={() => root.login()}>Login</button>
            </div>;
    } else {
        session_info = <div className="my-2">
            <p>Logged in as {session.display_name}</p>
            </div>
    }

    return <div className="row my-2">
        <div className="col-4">
        <a href="/"><h1>Project2</h1></a>
        </div>
        <div className="col-4">
        <p>
        <Link to={"/users"}>Users</Link>
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
