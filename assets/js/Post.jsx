import React from 'react';
import _ from 'lodash';

import api from './api';

// TODO make this a function after adding store...?
class Post extends React.Component {
  constructor(props) {
    super(props);

    this.post_id = props.match.params.id;

    // TODO investigate why it is being wrapped in 'data'...  
    this.state = {
      data: {
        content: "loading"
      },
      new_reply_content: ""
    }; 

    this.fetchPost();
  }

  updateState(state) {
    this.setState(state);
  }

  fetchPost() {
    console.log("fetch post");
    api.fetch_post(this.post_id, this.updateState.bind(this));
  }
  
  // this should only be called if a user is logged in
  createNewReply() {
    let content = this.state.new_reply_content;

    this.updateState({new_reply_content: ""});
    api.create_new_reply(this.props.session.user_id, this.post_id, content, this.fetchPost.bind(this));
  }

  render() {
    let replies = _.reverse(_.map(this.state.data.replies, (r) => (
      <div key={r.id}>
        <b>{r.username}</b>: {r.content}
      </div>
    ))); 
   
    let createReply; 
    if (this.props.session) {
      createReply = <div>
          <input type="text" placeholder="Reply..." value={this.state.new_reply_content} onChange={(ev) => this.updateState({new_reply_content: ev.target.value})} /> 
          <button className="btn btn-primary" onClick={this.createNewReply.bind(this)}>Reply</button>
        </div>;
    }
    return <div>
        <i><b>{this.state.data.username}</b> posted:</i> 
        <p>{this.state.data.content}</p>
        <hr />
        {replies}  
        {createReply}
      </div>;
  }
}

export default Post;
