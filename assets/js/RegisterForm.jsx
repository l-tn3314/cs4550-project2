import React from 'react';
import api from './api';
import _ from 'lodash';
import { Redirect } from 'react-router-dom';

// defines a form for user registration
class RegisterForm  extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
        error: false,
        registered: false
    };
  }

  register() {
    let self = this;
    let display_name = this.state.display_name;
    let email = this.state.email;
    let password = this.state.password;
    let hometown = this.state.hometown;
     $.ajax("/api/v1/users", {
         method: "post",
         dataType: "json",
         contentType: "application/json; charset=UTF-8",
         data: JSON.stringify({"user": {display_name, email, password, hometown}}),
         success:
          (resp) => {
              self.setState({registered: true});
          },
         error: (resp) => {
             self.setState({error: true});
         }
     });
  }

  update_register_form(state) {
      let state1 = _.assign({}, this.state, state);
      this.setState(state);
  }

  render() {
      let self = this;
      if (this.state.registered) {
          return <Redirect to="/" />;
      }
      let errmsg = [];
      if (this.state.error) {
          errmsg = <div className="alert alert-danger" role="alert">
              Error registering user
          </div>;
      }
      return <div>
            <h2>Register Here!</h2>
            {errmsg}
              <form action="javascript:void(0)" onSubmit={() => self.register()}>
                  <div className="form-group">
                      <label htmlFor="display_name">Display Name</label>
                      <input type="text" placeholder="John Smith" id="display_name"
                          className="form-control"
                          onChange={(ev) => self.update_register_form({display_name: ev.target.value})} />
                  </div>
                  <div className="form-group">
                      <label htmlFor="email">Email Address</label>
                      <input type="email" placeholder="john@example.com" id="email"
                          className="form-control"
                          onChange={(ev) => self.update_register_form({email: ev.target.value})} />
                  </div>
                  <div className="form-group">
                      <label htmlFor="password">Password</label>
                      <input type="password" id="password" placeholder="Enter password"
                          className="form-control"
                          onChange={(ev) => self.update_register_form({password: ev.target.value})} />
                  </div>
                  <div className="form-group">
                      <label htmlFor="hometown">Hometown</label>
                      <input type="text" id="hometown" placeholder="Boston, MA"
                          className="form-control"
                          onChange={(ev) => self.update_register_form({hometown: ev.target.value})} />
                  </div>
                  <button type="submit" className="btn btn-primary">Register</button>
              </form>
          </div>
  }
} 

export default RegisterForm;
