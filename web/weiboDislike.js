// Make sure you have under https://weibo.com/{uid}}/like page.
// This page is weibo which you 'Like'.

const weiboList = document.querySelectorAll('.WB_cardwrap.WB_feed_type.S_bg2.WB_feed_like')

for (const weibo of weiboList) {
    // Get weibo sender's name
    const nameEle = weibo.querySelector('.W_f14.W_fb.S_txt1')
    if (!nameEle) continue
    let name = nameEle.text.trim()
    if (!name || name === 'who you want to skip') continue;

    // Get "like" button
    const likeEle = weibo.querySelector('[yawf-handle-type=fl_like]>.S_txt2')
    if (!likeEle || !likeEle.title) continue;

    // If already "like", then click to dislike.
    if (likeEle.title === '取消赞') {
        likeEle.click()
    }
}
