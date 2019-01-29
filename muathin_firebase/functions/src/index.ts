import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as algoliaSearch from "algoliasearch";

admin.initializeApp();

const config = functions.config();
const algoliaClient = algoliaSearch(
  config.algolia.appid,
  config.algolia.apikey
);
const mosquesIndex = algoliaClient.initIndex("mosques");

exports.createMosque = functions.firestore
  .document("mosques/{mID}")
  .onCreate((snap, context) => {
    const objectID = snap.id;
    const data = snap.data();
    const name = data.name;
    const _geoloc = {
      lat: data.address.geoPoint._latitude,
      lng: data.address.geoPoint._longitude
    };

    return mosquesIndex.addObject({
      objectID,
      name,
      _geoloc
    });
  });

exports.deleteMosque = functions.firestore
  .document("mosques/{mID}")
  .onDelete((snap, context) => {
    const objectID = snap.id;

    return mosquesIndex.deleteObject(objectID);
  });
