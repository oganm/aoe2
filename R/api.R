aoe2netBase = function(x){
    if(is.null(options('aoe2netBase')$aoe2netBase)){
        'https://aoe2.net/api/'
    } else{
        options('aoe2netBase')$aoe2netBase
    }
}

getContent = function(url){
    raw = httr::GET(url = url)
    if(raw$status_code != 200){
        stop("Received a response with status ", raw$status_code, '\n', raw$error$message);
    }
    
    contentText = rawToChar(raw$content)
    
    assertthat::assert_that(jsonlite::validate(contentText))
    content = jsonlite::fromJSON(contentText,simplifyVector = FALSE)
    
    return(content)
}



rating_history = function(game = 'aoe2de', 
                          leaderboard_id = 3,
                          start = 0,
                          count = 10000,
                          steam_id = NULL,
                          profile_id = NULL){
    
    
    if(is.null(steam_id)){
        id = glue::glue("profile_id={profile_id}")
    }else{
        id = glue::glue('steam_id={steam_id}')
    }
    url = glue::glue('{aoe2netBase()}player/ratinghistory?game={game}&leaderboard_id={leaderboard_id}&start={start}&count={count}&{id}')
    getContent(url)
}


nullableString = function(...){
    args = list(...)
    
    if(is.null(args[[1]])){
        out = ''
    } else{
        out = glue::glue('{names(args[1])}={args[[1]]}')
    }
    return(out)
    
}

leaderboard = function(game= 'aoe2de',
                       leaderboard_id = 3,
                       start = 1,
                       count = 10000,
                       search = NULL,
                       steam_id = NULL,
                       profile_id = NULL){
    
    search = nullableString(search = search)
    steam_id = nullableString(steam_id = steam_id)
    profile_id = nullableString(profile_id = profile_id)
    
    url = glue::glue('{aoe2netBase()}leaderboard?game={game}&leaderboard_id={leaderboard_id}&start={start}&count={count}&{search}&{steam_id}&{profile_id}')
    getContent(url)
    
}


lobbies = function(game = 'aoe2de'){
    url = glue::glue('{aoe2netBase()}lobbies?game={game}')
    getContent(url)
}

last_match = function(game = 'aoe2de',
                      steam_id = NULL,
                      profile_id = NULL){
    
    if(is.null(steam_id)){
        id = glue::glue("profile_id={profile_id}")
    }else{
        id = glue::glue('steam_id={steam_id}')
    }
    
    url = glue::glue('{aoe2netBase()}player/lastmatch?game={game}&{id}')
    getContent(url)
    
}


match_history = function(game = 'aoe2de',
                         start = 0,
                         count = 1000,
                         steam_id = NULL,
                         profile_id = NULL){
    if(is.null(steam_id)){
        id = glue::glue("profile_id={profile_id}")
    }else{
        id = glue::glue('steam_id={steam_id}')
    }
    
    url = glue::glue('{aoe2netBase()}player/matches?game={game}&start={start}&count={count}&{id}')
    getContent(url)
    
}