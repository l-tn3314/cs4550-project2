import React from 'react';
import _ from 'lodash';
import { Link } from 'react-router-dom'

function WallPosts(props) {
  let {posts} = props;

  // TODO add hyperlinks for posts
  let allPosts = _.map(posts, (p) => (
    <div key={p.id}>
      <hr />
      <Link to={"/posts/" + p.id}>{p.content}</Link>
    </div>
  ));

  return <div>
      {allPosts}
    </div>;
}

export default WallPosts;
