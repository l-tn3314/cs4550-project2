import React from 'react';
import api from './api';
import _ from 'lodash';
import { Redirect } from 'react-router-dom';

// defines a form for user edits and deletes
class EditUserForm  extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
        user_id: props.user_id,
        error: false,
        edited: false,
        display_name: "Loading",
        email: "Loading",
        hometown: "Loading",
        logout_func: props.logout
    };
  }

  componentDidMount() {
      api.fetch_user(this.props.session.token, this.props.session.user_id, this.update_edit_form.bind(this))
  }

  edit() {
    let display_name = this.state.display_name;
    let email = this.state.email;
    let password = this.state.password;
    let hometown = this.state.hometown;
    let new_obj = {display_name, email, hometown};
    if (password != "") {
      new_obj.password = password;
    }
    
    let successFunc = (resp) => {
      this.setState({edited: true, error: false});
    };
    let errorFunc = (resp) => {
      this.setState({error: true});
    };
  
    api.update_user(this.props.session.token, this.props.session.user_id, new_obj, successFunc.bind(this), errorFunc.bind(this));
  }

  update_edit_form(state) {
      let state1 = _.assign({}, this.state, state);
      this.setState(state);
  }

  confirm_delete() {
    this.setState({confirm_delete: true});
  }

  actually_delete() {
    let successFunc = (resp) => {
      this.setState({redirect: true});
      this.props.logout();
    };
    let errorFunc = (resp) => {
      this.setState({error: true});
    };
   
    api.delete_user(this.props.session.token, this.props.session.user_id, successFunc.bind(this), errorFunc.bind(this));
  }

  render() {
      let self = this;
      if (this.state.redirect) {
          return <Redirect to="/" />;
      }
      let msg = [];
      if (this.state.error) {
          msg = <div className="alert alert-danger" role="alert">
              Error updating user
          </div>;
      } else if (this.state.edited) {
          msg = <div className="alert alert-info" role="alert">
              Changes saved
          </div>;
      }

      let confirm_delete = [];
      if (this.state.confirm_delete) {
        confirm_delete = <div>
            <h3> Are you sure?</h3>
            <button type="button" className="btn btn-danger" onClick={this.actually_delete.bind(this)}>Confirm Account Deletion</button>
        </div>;
      }

      return <div>
            <h2>Edit Profile</h2>
            {msg}
              <form action="javascript:void(0)" onSubmit={this.edit.bind(this)}>
                  <div className="form-group">
                      <label htmlFor="display_name">Display Name</label>
                      <input type="text" placeholder="John Smith" id="display_name" value={this.state.display_name}
                          className="form-control"
                          onChange={(ev) => self.update_edit_form({display_name: ev.target.value})} />
                  </div>
                  <div className="form-group">
                      <label htmlFor="email">Email Address</label>
                      <input type="email" placeholder="john@example.com" id="email" value={this.state.email}
                          className="form-control"
                          onChange={(ev) => self.update_edit_form({email: ev.target.value})} />
                  </div>
                  <div className="form-group">
                      <label htmlFor="password">Password</label>
                      <input type="password" id="password" placeholder="Enter new password or leave blank"
                          className="form-control"
                          onChange={(ev) => self.update_edit_form({password: ev.target.value})} />
                  </div>
                  <div className="form-group">
                      <label htmlFor="hometown">Hometown</label>
                      <input type="text" id="hometown" placeholder="Boston, MA" value={this.state.hometown}
                          className="form-control"
                          onChange={(ev) => self.update_edit_form({hometown: ev.target.value})} />
                  </div>
                  <button type="submit" className="btn btn-primary">Save</button>
              </form>
            <h2>Danger Zone</h2>
            <button type="button" className="btn btn-warning" onClick={() => self.confirm_delete()}>Delete Account</button>
            {confirm_delete}
          </div>
  }
} 

export default EditUserForm;
