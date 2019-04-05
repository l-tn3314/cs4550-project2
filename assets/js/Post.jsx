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
      }
    }; 

    api.fetch_post(this.post_id, this.updateState.bind(this));
  }

  updateState(state) {
    this.setState(state);
  }

  render() {
    let replies = _.map(this.state.data.replies, (r) => (
      <div key={r.id}>
        <b>{r.username}</b>: {r.content}
      </div>
    )); 
    
    return <div>
        <i><b>{this.state.data.username}</b> posted:</i> 
        <p>{this.state.data.content}</p>
        <hr />
        {replies}  
      </div>;
  }
}

export default Post;
