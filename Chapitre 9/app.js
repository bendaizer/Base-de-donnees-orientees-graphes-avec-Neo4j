var db = require('seraph')({
  user: 'user',
  pass: 'pass'
});

var Twit = require('twit');
config = require('./config.js');


var T = new Twit(config);

db.constraints.uniqueness.create('Tweet', 'tweet_id', function(err, constraint) {
  console.log(constraint);
});
db.constraints.uniqueness.create('User', 'user', function(err, constraint) {
  console.log(constraint);
});
db.constraints.uniqueness.create('Hashtag', 'hashtag', function(err, constraint) {
  console.log(constraint);
});


var stream = T.stream('statuses/filter', { track: '#Schengen' });

stream.on('tweet', function (tweet, err) {

    hashtags = new Array();
    tweet.entities.hashtags.forEach(function(hashtag){
    	hashtags.push({hashtag: hashtag.text});	
    })

    mentions = new Array();
    tweet.entities.user_mentions.forEach(function(mention){
    	mentions.push({mentioned: mention.screen_name});	
    })

	db.query([
		"MERGE (t:Tweet {tweet_id:{tweet_id}})",
		"MERGE (u:User {user: {user}})",
		"CREATE u-[:TWEETED]->t",
		"FOREACH (node in {hashtags} | MERGE(h:Hashtag {hashtag: node.hashtag})",
		"CREATE t-[:HAS_HASHTAG]->h)",
		"FOREACH (node in {mentions} | MERGE(m:User {user: node.mentioned})",
		"CREATE t<-[:IS_MENTIONED]-m)"
		].join(' '),
		{
			"tweet_id": tweet.id_str,
			"user": tweet.user.screen_name,
			"hashtags": hashtags,
			"mentions": mentions
		}, function(err, result) {
			if (err) throw err;
			console.log(result);
		})
});
