var Post = React.createClass({
  propTypes: {
    title: React.PropTypes.string,
    content: React.PropTypes.string
  },

  path: function() {
    return "/posts/" + this.props.id;
  },

  render: function() {
    return (
      <div>
        <div>Title: {this.props.title}</div>
        <div class="js-content">{this.props.content}</div>
        <div><a class="js-expand-content">Expand</a></div>
      </div>
    );
  }
});
