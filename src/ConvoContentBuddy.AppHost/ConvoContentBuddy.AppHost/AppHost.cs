var builder = DistributedApplication.CreateBuilder(args);

var apiBrain = builder.AddProject<Projects.ConvoContentBuddy_API_Brain>("api-brain");
var apiTranscription = builder.AddProject<Projects.ConvoContentBuddy_API_Transcription>("api-transcription");
var apiVectorSearch = builder.AddProject<Projects.ConvoContentBuddy_API_VectorSearch>("api-vectorsearch");

var apiGateway = builder.AddProject<Projects.ConvoContentBuddy_API_Gateway>("api-gateway")
    .WithReference(apiBrain)
    .WithReference(apiTranscription)
    .WithReference(apiVectorSearch);

builder.AddProject<Projects.ConvoContentBuddy_UI_Web>("ui-web")
    .WithReference(apiGateway);

builder.AddProject<Projects.ConvoContentBuddy_Data_Seeder>("data-seeder")
    .WithReference(apiBrain)
    .WithReference(apiVectorSearch);

builder.Build().Run();
