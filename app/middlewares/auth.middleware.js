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
      total_loot: user.total_loot,
      total_loot_won: user.total_loot_won,
      loose_loost: user.loose_loost,
      uid: user.uid,
      fullname: user.fullname,
      avatar_url: user.avatar_url
    }
    next() // pass the execution off to whatever request the client intended
  })
}