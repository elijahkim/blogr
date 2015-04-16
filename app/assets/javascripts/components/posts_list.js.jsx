var PostsList = React.createClass({
  getInitialState: function() {
    return { posts: [] };
  },

  componentDidMount: function() {
    $.ajax({
      url: "/posts",
      dataType: "json",
      success: function(posts) {
        this.setState({ posts: posts });
      }.bind(this),
      error: function(xhr, status, err) {
        console.error("its broken");
      }.bind(this)
    });
  },

  render: function() {
    var postNodes = this.state.posts.map(function (post) {
      return (
        <Post title={post.title} content={post.content} />
      )
    });

    return (
      <div>
        {postNodes}
      </div>
    );
  }
});
