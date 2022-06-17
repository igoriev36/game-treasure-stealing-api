/**
 * User Controller
 */
const Hero = require('../models/Hero');

exports.updateHeroStatus = async (req, res) => {
	// console.log(req)
	let update = false;
	const hero_mint = req.body.hero_mint;
	const user_id = req.user.id;

	const hero = await Hero.findOne({ where: {mint: hero_mint, user_id: user_id} })
	if(hero){
		let status = hero.active;
		if(status === null || status === ''){
			status = 1;
		}else{
			status = !status;
		}

		hero.active = !status? 0: 1;
		update = await hero.save();
	}

	res.json({ 
		success: true,
		update: update
	});
}