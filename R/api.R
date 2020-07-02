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

