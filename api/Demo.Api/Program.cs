var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/health", () => Results.Ok(new { status = "ok" }));
app.MapGet("/products", () => new[] {
    new { id = 1, name = "Re:Fuel Program" },
    new { id = 2, name = "AI Dev PAckage" }
});

app.Run();