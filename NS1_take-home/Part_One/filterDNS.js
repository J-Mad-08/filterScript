// https://ns1.com/api?docId=2185
// https://github.com/ns1/ns1-js
const NS1 = require('ns1');
require('dotenv').config();

NS1.set_api_key(process.env.API_KEY);
// Use the NS1 API to add a third answer with correct metadata (geography) to your A record with the third server IP listed above.
//ns1.github.io/ns1-js/NS1.Record.html
// update the record update(attributes)
NS1.Zone.find(`${process.env.ZONE}/${process.env.DOMAIN}/A`).then(
	async (record) => {
		const { answers } = record.attributes;
		try {
			// https://www.demo2s.com/node.js/node-js-ns1-ns1request-catch-arrow-function.html has a dif approach
			const updatedRecord = await record
				.update({
					answers: [
						...answers,
						{
							answer: ['120.2.3.36'],
							id: '63bbbdeb8e7fcc0081ec1e2f',
							meta: {
								georegion: ['US-EAST'],
							},
						},
					],
					use_client_subnet: false,
				})
				// not sure why the zone attributes are updated but there is is an unknown field meta in dns.zone.UpdateRequest thats blocking the return
				/**
				 * http://ns1.github.io/ns1-js/rest_resource.js.html#line28
				 * underlying Object.assign() could be the cause
				 */
				.then(console.log('SUCCESS HANDLER: ', record));
			return updatedRecord;
		} catch (e) {
			// able to see the new answer has been appended but failed
			console.log(record.attributes.answers);
			console.error('ERROR', e.message);
			return record;
		}
	}
);

// cmd line approach
// curl -X POST -H 'X-NSONE-Key: $NSONE_API_KEY' -d '{"use_client_subnet":false}' https://api.nsone.net/v1/zones/{zone_name}/{domain}/{type}
