//Auth middleware
const jwt = require('jsonwebtoken');

exports.authenticateToken = (req, res, next) => {
  // Gather the jwt access token from the request header
  const authHeader = req.headers['authorization']
  const token = authHeader && authHeader.split(' ')[1]
  if (token == null) return res.sendStatus(401) // if there isn't any token

  jwt.verify(token, process.env.TOKEN_SECRET, (err, user) => {
    //console.log(user)
    if (err) return res.sendStatus(403)
    req.user = {
    	id: parseInt(user.id),
    	username: user.username,
      email: user.email,
      avatar: user.avatar_url,
      display_name: user.display_name || ''
    }
    next() // pass the execution off to whatever request the client intended
  })
}