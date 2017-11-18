var path = require('path')

module.exports = {
  entry: path.join(__dirname, 'src/', 'app.jsx'),
  output: {
    path: path.join(__dirname, 'src/static/build'),
    filename: 'app.bundle.js'
  },
  module: {
    loaders: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['react', 'env']
        }
      },
      {
        test: /\.scss$/,
        use: ['style-loader', 'css-loader', 'sass-loader']
      },
      {
        test: /\.json$/,
        loader: 'json-loader'
      }
    ]
  }
}