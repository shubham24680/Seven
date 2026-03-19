class SportsModel {
  final String? status;
  final Response? response;
  final String? message;
  final String? etag;
  final String? apiVersion;
  final DateTime? modified;
  final DateTime? datetime;

  SportsModel({
    this.status,
    this.response,
    this.message,
    this.etag,
    this.apiVersion,
    this.modified,
    this.datetime,
  });

  factory SportsModel.fromJson(Map<String, dynamic> json) => SportsModel(
        status: json["status"],
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
        message: json["message̐"],
        etag: json["etag"],
        apiVersion: json["api_version"],
        // modified: json["modified"] == null
        //     ? null
        //     : DateTime.parse(json["modified"].replaceAll(' ', 'T')),
        // datetime: json["datetime"] == null
        //     ? null
        //     : DateTime.parse(json["datetime"].replaceAll(' ', 'T')),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response?.toJson(),
        "message": message,
        "etag": etag,
        "api_version": apiVersion,
        "modified": modified?.toIso8601String(),
        "datetime": datetime?.toIso8601String(),
      };
}

class Response {
  final List<Item>? items;
  final int? totalItems;
  final int? totalPages;

  Response({
    this.items,
    this.totalItems,
    this.totalPages,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        totalItems: json["total_items"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "total_items": totalItems,
        "total_pages": totalPages,
      };
}

class Item {
  final int? matchId;
  final String? title;
  final String? shortTitle;
  final String? subtitle;
  final String? matchNumber;
  final int? format;
  final String? formatStr;
  final int? status;
  final String? statusStr;
  final String? statusNote;
  final String? verified;
  final String? preSquad;
  final String? oddsAvailable;
  final int? gameState;
  final String? gameStateStr;
  final String? domestic;
  final Competition? competition;
  final Team? teama;
  final Team? teamb;
  final DateTime? dateStart;
  final DateTime? dateEnd;
  final int? timestampStart;
  final int? timestampEnd;
  final DateTime? dateStartIst;
  final DateTime? dateEndIst;
  final Venue? venue;
  final String? umpires;
  final String? referee;
  final String? equation;
  final String? live;
  final String? result;
  final String? resultType;
  final String? winMargin;
  final int? winningTeamId;
  final int? commentary;
  final int? wagon;
  final int? latestInningNumber;
  final DateTime? presquadTime;
  final String? verifyTime;
  final String? matchDlsAffected;
  final String? tossDecisionVerify;
  final String? tossWinnerVerify;
  final String? resultTypeVerify;
  final String? playerOfTheMatchVerify;
  final Toss? toss;
  final dynamic liveOdds;

  Item({
    this.matchId,
    this.title,
    this.shortTitle,
    this.subtitle,
    this.matchNumber,
    this.format,
    this.formatStr,
    this.status,
    this.statusStr,
    this.statusNote,
    this.verified,
    this.preSquad,
    this.oddsAvailable,
    this.gameState,
    this.gameStateStr,
    this.domestic,
    this.competition,
    this.teama,
    this.teamb,
    this.dateStart,
    this.dateEnd,
    this.timestampStart,
    this.timestampEnd,
    this.dateStartIst,
    this.dateEndIst,
    this.venue,
    this.umpires,
    this.referee,
    this.equation,
    this.live,
    this.result,
    this.resultType,
    this.winMargin,
    this.winningTeamId,
    this.commentary,
    this.wagon,
    this.latestInningNumber,
    this.presquadTime,
    this.verifyTime,
    this.matchDlsAffected,
    this.tossDecisionVerify,
    this.tossWinnerVerify,
    this.resultTypeVerify,
    this.playerOfTheMatchVerify,
    this.toss,
    this.liveOdds,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        matchId: json["match_id"],
        title: json["title"],
        shortTitle: json["short_title"],
        subtitle: json["subtitle"],
        matchNumber: json["match_number"],
        format: json["format"],
        formatStr: json["format_str"],
        status: json["status"],
        statusStr: json["status_str"],
        statusNote: json["status_note"],
        verified: json["verified"],
        preSquad: json["pre_squad"],
        oddsAvailable: json["odds_available"],
        gameState: json["game_state"],
        gameStateStr: json["game_state_str"],
        domestic: json["domestic"],
        competition: json["competition"] == null
            ? null
            : Competition.fromJson(json["competition"]),
        teama: json["teama"] == null ? null : Team.fromJson(json["teama"]),
        teamb: json["teamb"] == null ? null : Team.fromJson(json["teamb"]),
        // dateStart: json["date_start"] == null
        //     ? null
        //     : DateTime.parse(json["date_start"].replaceAll(' ', 'T')),
        // dateEnd: json["date_end"] == null
        //     ? null
        //     : DateTime.parse(json["date_end"].replaceAll(' ', 'T')),
        timestampStart: json["timestamp_start"],
        timestampEnd: json["timestamp_end"],
        // dateStartIst: json["date_start_ist"] == null
        //     ? null
        //     : DateTime.parse(json["date_start_ist"].replaceAll(' ', 'T')),
        // dateEndIst: json["date_end_ist"] == null
        //     ? null
        //     : DateTime.parse(json["date_end_ist"].replaceAll(' ', 'T')),
        venue: json["venue"] == null ? null : Venue.fromJson(json["venue"]),
        umpires: json["umpires"],
        referee: json["referee"],
        equation: json["equation"],
        live: json["live"],
        result: json["result"],
        resultType: json["result_type"],
        winMargin: json["win_margin"],
        winningTeamId: json["winning_team_id"],
        commentary: json["commentary"],
        wagon: json["wagon"],
        latestInningNumber: json["latest_inning_number"],
        // presquadTime: json["presquad_time"] == null
        //     ? null
        //     : DateTime.parse(json["presquad_time"].replaceAll(' ', 'T')),
        verifyTime: json["verify_time"],
        matchDlsAffected: json["match_dls_affected"],
        tossDecisionVerify: json["toss_decision_verify"],
        tossWinnerVerify: json["toss_winner_verify"],
        resultTypeVerify: json["result_type_verify"],
        playerOfTheMatchVerify: json["player_of_the_match_verify"],
        toss: json["toss"] == null ? null : Toss.fromJson(json["toss"]),
        liveOdds: json["live_odds"],
      );

  Map<String, dynamic> toJson() => {
        "match_id": matchId,
        "title": title,
        "short_title": shortTitle,
        "subtitle": subtitle,
        "match_number": matchNumber,
        "format": format,
        "format_str": formatStr,
        "status": status,
        "status_str": statusStr,
        "status_note": statusNote,
        "verified": verified,
        "pre_squad": preSquad,
        "odds_available": oddsAvailable,
        "game_state": gameState,
        "game_state_str": gameStateStr,
        "domestic": domestic,
        "competition": competition?.toJson(),
        "teama": teama?.toJson(),
        "teamb": teamb?.toJson(),
        "date_start": dateStart?.toIso8601String(),
        "date_end": dateEnd?.toIso8601String(),
        "timestamp_start": timestampStart,
        "timestamp_end": timestampEnd,
        "date_start_ist": dateStartIst?.toIso8601String(),
        "date_end_ist": dateEndIst?.toIso8601String(),
        "venue": venue?.toJson(),
        "umpires": umpires,
        "referee": referee,
        "equation": equation,
        "live": live,
        "result": result,
        "result_type": resultType,
        "win_margin": winMargin,
        "winning_team_id": winningTeamId,
        "commentary": commentary,
        "wagon": wagon,
        "latest_inning_number": latestInningNumber,
        "presquad_time": presquadTime?.toIso8601String(),
        "verify_time": verifyTime,
        "match_dls_affected": matchDlsAffected,
        "toss_decision_verify": tossDecisionVerify,
        "toss_winner_verify": tossWinnerVerify,
        "result_type_verify": resultTypeVerify,
        "player_of_the_match_verify": playerOfTheMatchVerify,
        "toss": toss?.toJson(),
        "live_odds": liveOdds,
      };
}

class Competition {
  final int? cid;
  final String? title;
  final String? abbr;
  final String? type;
  final String? category;
  final String? matchFormat;
  final String? season;
  final String? status;
  final DateTime? datestart;
  final DateTime? dateend;
  final String? country;
  final String? totalMatches;
  final String? totalRounds;
  final String? totalTeams;
  final String? logoUrl;
  final String? tournamentId;
  final String? standingAvailable;
  final Broadcast? broadcast;

  Competition({
    this.cid,
    this.title,
    this.abbr,
    this.type,
    this.category,
    this.matchFormat,
    this.season,
    this.status,
    this.datestart,
    this.dateend,
    this.country,
    this.totalMatches,
    this.totalRounds,
    this.totalTeams,
    this.logoUrl,
    this.tournamentId,
    this.standingAvailable,
    this.broadcast,
  });

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
        cid: json["cid"],
        title: json["title"],
        abbr: json["abbr"],
        type: json["type"],
        category: json["category"],
        matchFormat: json["match_format"],
        season: json["season"],
        status: json["status"],
        // datestart: json["datestart"] == null
        //     ? null
        //     : DateTime.parse(json["datestart"].replaceAll(' ', 'T')),
        // dateend: json["dateend"] == null
        //     ? null
        //     : DateTime.parse(json["dateend"].replaceAll(' ', 'T')),
        country: json["country"],
        totalMatches: json["total_matches"],
        totalRounds: json["total_rounds"],
        totalTeams: json["total_teams"],
        logoUrl: json["logo_url"],
        tournamentId: json["tournament_id"],
        standingAvailable: json["standing_available"],
        broadcast: json["broadcast"] == null
            ? null
            : Broadcast.fromJson(json["broadcast"]),
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "title": title,
        "abbr": abbr,
        "type": type,
        "category": category,
        "match_format": matchFormat,
        "season": season,
        "status": status,
        "datestart":
            "${datestart!.year.toString().padLeft(4, '0')}-${datestart!.month.toString().padLeft(2, '0')}-${datestart!.day.toString().padLeft(2, '0')}",
        "dateend":
            "${dateend!.year.toString().padLeft(4, '0')}-${dateend!.month.toString().padLeft(2, '0')}-${dateend!.day.toString().padLeft(2, '0')}",
        "country": country,
        "total_matches": totalMatches,
        "total_rounds": totalRounds,
        "total_teams": totalTeams,
        "logo_url": logoUrl,
        "tournament_id": tournamentId,
        "standing_available": standingAvailable,
        "broadcast": broadcast?.toJson(),
      };
}

class Broadcast {
  final List<String>? tv;
  final List<String>? ott;

  Broadcast({
    this.tv,
    this.ott,
  });

  factory Broadcast.fromJson(Map<String, dynamic> json) => Broadcast(
        tv: json["tv"] == null
            ? []
            : List<String>.from(json["tv"]!.map((x) => x)),
        ott: json["ott"] == null
            ? []
            : List<String>.from(json["ott"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "tv": tv == null ? [] : List<dynamic>.from(tv!.map((x) => x)),
        "ott": ott == null ? [] : List<dynamic>.from(ott!.map((x) => x)),
      };
}

class LiveOddsClass {
  final Matchodds? matchodds;

  LiveOddsClass({
    this.matchodds,
  });

  factory LiveOddsClass.fromJson(Map<String, dynamic> json) => LiveOddsClass(
        matchodds: json["matchodds"] == null
            ? null
            : Matchodds.fromJson(json["matchodds"]),
      );

  Map<String, dynamic> toJson() => {
        "matchodds": matchodds?.toJson(),
      };
}

class Matchodds {
  final MatchoddsTeama? teama;
  final MatchoddsTeama? teamb;

  Matchodds({
    this.teama,
    this.teamb,
  });

  factory Matchodds.fromJson(Map<String, dynamic> json) => Matchodds(
        teama: json["teama"] == null
            ? null
            : MatchoddsTeama.fromJson(json["teama"]),
        teamb: json["teamb"] == null
            ? null
            : MatchoddsTeama.fromJson(json["teamb"]),
      );

  Map<String, dynamic> toJson() => {
        "teama": teama?.toJson(),
        "teamb": teamb?.toJson(),
      };
}

class MatchoddsTeama {
  final String? back;
  final String? lay;

  MatchoddsTeama({
    this.back,
    this.lay,
  });

  factory MatchoddsTeama.fromJson(Map<String, dynamic> json) => MatchoddsTeama(
        back: json["back"],
        lay: json["lay"],
      );

  Map<String, dynamic> toJson() => {
        "back": back,
        "lay": lay,
      };
}

class Team {
  final int? teamId;
  final String? name;
  final String? shortName;
  final String? logoUrl;
  final String? scoresFull;
  final String? scores;
  final String? overs;

  Team({
    this.teamId,
    this.name,
    this.shortName,
    this.logoUrl,
    this.scoresFull,
    this.scores,
    this.overs,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        teamId: json["team_id"],
        name: json["name"],
        shortName: json["short_name"],
        logoUrl: json["logo_url"],
        scoresFull: json["scores_full"],
        scores: json["scores"],
        overs: json["overs"],
      );

  Map<String, dynamic> toJson() => {
        "team_id": teamId,
        "name": name,
        "short_name": shortName,
        "logo_url": logoUrl,
        "scores_full": scoresFull,
        "scores": scores,
        "overs": overs,
      };
}

class Toss {
  final String? text;
  final int? winner;
  final int? decision;

  Toss({
    this.text,
    this.winner,
    this.decision,
  });

  factory Toss.fromJson(Map<String, dynamic> json) => Toss(
        text: json["text"],
        winner: json["winner"],
        decision: json["decision"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "winner": winner,
        "decision": decision,
      };
}

class Venue {
  final String? venueId;
  final String? name;
  final String? location;
  final String? country;
  final String? timezone;

  Venue({
    this.venueId,
    this.name,
    this.location,
    this.country,
    this.timezone,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        venueId: json["venue_id"],
        name: json["name"],
        location: json["location"],
        country: json["country"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "venue_id": venueId,
        "name": name,
        "location": location,
        "country": country,
        "timezone": timezone,
      };
}
