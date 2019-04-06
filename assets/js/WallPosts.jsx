import React from 'react';
import _ from 'lodash';
import { Link } from 'react-router-dom';

import api from './api';

function WallPosts(props) {
  let {posts, session, deleteCallback} = props;

  let onDelete = (id) => {
    api.delete_post(id, deleteCallback);
  };

  // TODO add hyperlinks for posts
  let allPosts = _.map(posts, (p) => {
    let deleteButton;
      if (session && session.user_id == p.user_id) {
        deleteButton = <button className="btn btn-danger" onClick={() => onDelete(p.id)}>delete</button>
      }
    return <div key={p.id}>
      <hr />
      <Link to={"/posts/" + p.id}>{p.content}</Link>
      {deleteButton}
    </div>
  });

  return <div>
      {allPosts}
    </div>;
}

export default WallPosts;
