using Microsoft.AspNetCore.Mvc;

namespace BusTicketing.Api.Controllers;

/// <summary>
/// Endpoint kiem tra he thong co dang chay khong.
/// Dung de test nhanh khi moi clone du an ve.
/// </summary>
[ApiController]
[Route("api/[controller]")]
public class HealthController : ControllerBase
{
    /// <summary>Kiem tra API con song khong.</summary>
    /// <response code="200">API dang chay binh thuong</response>
    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public IActionResult Get()
    {
        return Ok(new
        {
            success = true,
            data = new
            {
                status = "OK",
                service = "Bus Ticketing API",
                version = "1.0.0",
                serverTime = DateTime.Now
            },
            message = (string?)null
        });
    }
}
