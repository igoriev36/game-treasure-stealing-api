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
    	wallet: user.wallet_address,
      avatar_url: user.avatar_url,
      sol_balance: user.sol_balance,
      loot_total: user.loot_total,
      uid: user.uid,
      fullname: user.fullname,
    }
    next() // pass the execution off to whatever request the client intended
  })
}