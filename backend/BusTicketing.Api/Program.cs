var builder = WebApplication.CreateBuilder(args);

// ============================================================
//  SERVICES - Dang ky cac dich vu
// ============================================================

builder.Services.AddControllers();

// Swagger - giao dien thu API tai /swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// CORS - cho phep frontend goi API.
// Luc dev thi Vite proxy da lo viec nay, nhung van giu
// de phong khi chay frontend o cong khac.
builder.Services.AddCors(options =>
{
    options.AddPolicy("DevCors", policy =>
    {
        policy
            .WithOrigins(
                "http://localhost:5173",
                "https://localhost:5173")
            .AllowAnyHeader()
            .AllowAnyMethod()
            .AllowCredentials();
    });
});

var app = builder.Build();

// ============================================================
//  PIPELINE - Cac buoc xu ly request
// ============================================================

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseCors("DevCors");

app.UseAuthorization();

app.MapControllers();

app.Run();
