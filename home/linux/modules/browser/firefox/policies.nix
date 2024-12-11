{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  ThirdParty = "3rdparty";
  extensions = import ./extension_ids.nix {};
in {
  AppAutoUpdate = false;
  RequestedLocales = "es-ES,es,en-US,en";

  DisableTelemetry = true; # sets
  # datareporting.healthreport.uploadEnabled = false;
  # datareporting.policy.dataSubmissionEnabled = false;
  # toolkit.telemetry.archive.enabled = false;

  DisableFirefoxStudies = true; # does not affect preferences

  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true; # sets privacy.trackingprotection.crytomining.enabled = true
    Fingerprinting = true; # sets privacy.trackingprotection.fingerprinting.enabled = true
  };

  SanitizeOnShutdown = {
    Downloads = true; # sets privacy.clearOnShutdown.downloads
    History = true; # sets privacy.clearOnShutdown.history
    Locked = true;
  };

  DisablePocket = true; # sets extensions.pocket.enabled to false;
  DisableFirefoxAccounts = true; # sets identity.fxaccounts.enabled to false;
  DisableFirefoxScreenshots = false; # sets extensions.screenshots.disabled to false;
  DontCheckDefaultBrowser = true;
  DisplayBookmarksToolbar = "always"; # alternatives: "always" or "newtab"
  SearchBar = "unified"; # alternative: "separate"

  ExtensionSettings = with extensions; {
    # also blocks about:debugging
    "*".installation_mode = "blocked"; # blocks all addons except the ones specified below

    "${ublock_origin}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      installation_mode = "force_installed";
    };
    "${solid_black_theme}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/solid-black-theme/latest.xpi";
      installation_mode = "force_installed";
    };
    "${dark_reader}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
      installation_mode = "force_installed";
    };
    "${bitwarden}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
      installation_mode = "allowed";
    };
    "${violentmonkey}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
      installation_mode = "allowed";
    };
    "${sponsorblock}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/file/4364207/sponsorblock-5.9.4.xpi";
      installation_mode = "allowed";
    };
    "${MAL_sync}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/file/4340167/mal_sync-0.10.4_FEogeJR.xpi";
      installation_mode = "allowed";
    };
    "${zotero_connector}" = {
      install_url = "https://download.zotero.org/connector/firefox/release/Zotero_Connector-5.0.147.xpi";
      installation_mode = "force_installed";
    };
    "${omnivore}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/file/4246656/omnivore-2.10.0.xpi";
      installation_mode = "allowed";
    };
    "${translate-web-pages}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/file/4245500/traduzir_paginas_web-10.0.1.1.xpi";
      installation_mode = "force_installed";
    };
    "${enhancer_for_youtube}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/file/4393561/enhancer_for_youtube-2.0.130.1.xpi";
      installation_mode = "force_installed";
    };
  };

  ${ThirdParty}.Extensions = {
    "uBlock0@raymondhill.net" = import ../shared/ublock_origin {inherit lib;};
  };

  Preferences = {
    # Philosophy: Lock as much as possible so that we have to change stuff in Nix for reproducibility

    # A lot of the security and privacy stuff was taken from
    # https://brainfucksec.github.io/firefox-hardening-guide

    # UI configurations
    "browser.aboutConfig.showWarning" = false;
    "browser.aboutwelcome.enabled" = false;
    "browser.tabs.firefox-view" = false;
    "browser.tabs.tabmanager.enabled" = false;
    "browser.startup.page" = 3;
    "browser.search.openintab" = true;

    # Adblocking and Annoyances
    "browser.contentblocking.features.strict" = "tp,tpPrivate,cookieBehavior5,cookieBehaviorPBM5,cm,fp,stp,emailTP,emailTPPrivate,lvl2,rp,rpTop,ocsp,qps,qpsPBM,fpp,fppPrivate";
    "browser.contentblocking.category" = "strict";
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.newtabpage.activity-stream.topSitesRows" = 2;
    "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
    "browser.newtabpage.activity-stream.feeds.topsites" = true;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "signon.rememberSignons" = false;
    "signon.autofillForms" = false;
    "signon.formlessCapture.enabled" = false;

    # Form autofill
    "browser.formfill.enable" = false;
    "extensions.formautofill.available" = "off";
    "extensions.formautofill.addresses.enabled" = false;
    "extensions.formautofill.heuristics.enabled" = false;
    "extensions.formautofill.creditCards.enabled" = false;
    "extensions.formautofill.creditCards.available" = false;

    # Enable extensions on all pages
    "extensions.enabledScopes" = 5;
    "extensions.webextensions.restrictedDomains" = "";

    # Privacy
    "extensions.pocket.enabled" = false;
    "geo.provider.use_gpsd" = false;
    "geo.provider.use_geoclue" = false;

    # Telemetry
    "browser.newtabpage.activity-stream.feeds.telemetry" = false;
    "browser.newtabpage.activity-stream.telemetry" = false;
    "browser.newtabpage.activity-stream.feeds.snippets" = false;
    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
    "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
    "extensions.getAddons.showPane" = false; # uses Google Analytics
    "extensions.htmlaboutaddons.recommendations.enabled" = false;
    "browser.discovery.enabled" = false;
    "browser.ping-centre.telemetry" = false;

    # No crash reports
    "browser.tabs.crashReporting.sendReport" = false;

    # HTTPS/SSL/TLS/OSCP/CERTS
    "dom.security.https_only_mode" = true;
    "dom.security.https_only_mode_send_http_background_request" = false;
    "browser.xul.error_pages.expert_bad_cert" = true;
    "security.tls.enable_0rtt_data" = false;
    "security.OCSP.require" = true;

    # Misc security
    "network.IDN_show_punycode" = true;
  };
}
