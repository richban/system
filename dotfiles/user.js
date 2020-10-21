/**
 * Maximize Firefox Browser Privacy and Security
 * Based on: https://www.youtube.com/watch?v=xxWXLlfqNAo&list=PL3cu45aM3C2BwSi8Nj5aBWTrbjbHiXxQo&index=1
 * Mental Outlaw ***/

// WebRTC can give up your real IP even when using VPN or Tor
user_pref("media.peerconnection.enabled", false);
/*** Enable fingerprint resistance:  With this alone we pretty much 
 * negate the need for canvas defender, or any other fingerprint blocking addon
 * ***/
user_pref("privacy.resistfingerprinting", true)
// 3DES has known security flaws
user_pref("security.ssl3.rsa_des_ede3_sha", false)
// Require Safe Negotiation:  Optimize SSL
user_pref("security.ssl.require_safe_negotiation", true);
// Disable TLS 1.0, 1.1
user_pref("security.tls.version.min", 3);
// enables TLS 1.3
user_pref("tls.version.max", 4);
// Disable 0 round trip time to better secure your forward secrecy
user_pref("security.tls.enable_0rtt_data", false);
// Disable Automatic Formfill
user_pref("browser.formfil.enable", false);
// Disable disk caching
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.disk_cache_ssl", false);
user_pref("browser.cache.memory.enable", false);
user_pref("browser.cache.offline.enable", false);
user_pref("browser.cache.insecure.enable", false);
// Disable geolocation services
user_pref("geo.enabled", false);
// Disable plugin scanning.
user_pref("plugin.scan.plid.all", false);
// Disable ALL telemetery
user_pref("browser.newtabpage.activity-stream.feeds.telemetry browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.pingcentre.telemetry", false);
user_pref("devtools.onboarding.telemetry-logged", false);
user_pref("media.wmf.deblacklisting-for-telemetry-in-gpu-process", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrping.enabled", false);
user_pref("toolkit.telemetry.firstshutdownping.enabled", false);
user_pref("toolkit.telemetry.hybridcontent.enabled", false);
user_pref("toolkit.telemetry.newprofileping.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.updateping.enabled", false);
user_pref("toolkit.telemetry.shutdownpingsender.enabled", false);
// Allows direct access to GPU.
user_pref("webgl.disabled", true);
/*
 * Enable first-party isolation. Prevents browsers from making requests 
 * outside of the primary domain of the website. Prevents supercookies. 
 * may cause websites that rely on 3rd party scripts and libraries to break, 
 * however those are generally only used for tracking so fuck em anyway. **/
user_pref("privacy.firstparty.isolate", true);
// Disable TLS false start
user_pref("security.ssl.enable_false_start", false);

