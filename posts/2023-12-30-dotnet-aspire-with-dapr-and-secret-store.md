---
title: .Net Aspire Preview 2 with Dapr and the secretstore
date: 2024-01-02T13:43:00 -5:00
author: gabrewer
comments: true
categories: Development, .Net
tags: post
---

In my recent SaaS personal projects, I've been exploring the capabilities of Dapr, based off of the [eShopOnDapr](https://github.com/dotnet-architecture/eShopOnDapr) sample. Dapr, with its integrated APIs and best practices for building distributed applications, has significantly streamlined my development process. [Learn more about Dapr](https://dapr.io/).

I've also been incorporating architectural insights and best practices from YouTube channels like Milan Jovanovic, Nick Chapsas, and Codewrinkles. Their guidance has refinined my approach to these solutions especially around using MediatR, Vertical Slice architecture and performance. Check out their insights:

- [Milan Jovanovic's YouTube Channel](https://www.youtube.com/@MilanJovanovicTech)
- [Nick Chapsas's YouTube Channel](https://www.youtube.com/@nickchapsas)
- [Codewrinkles's YouTube Channel](https://www.youtube.com/@Codewrinkles)

The release of .NET 8 introduced the .NET Aspire 8.0 Preview 1 - an opinionated, cloud-ready stack ideal for building observable, production-ready, distributed applications compatible with Dapr. [View .NET Aspire on GitHub](https://github.com/dotnet/aspire).

Integrating .NET Aspire into my projects was pretty straightforward. However, I encountered a few challenges, especially with Dapr configuration management across projects. I ended up copying the dapr config files into each projects. Aslo .NET Aspire Preview 1 lacked support for deploying Dapr components to Azure.

With the advent of Preview 2, which impoves supports Dapr, I successfully updated my projects. However, I faced a challenge with the secret store configuration:

```csharp
var secretStore = builder.AddDaprComponent("gab-secretstore", "secretstores", new
    DaprComponentOptions { LocalPath = "../dapr/components/" });

var apiService = builder.AddProject<Projects.gabMileage_Mileage_Api>("mileage-api")
    .WithDaprSidecar()
    .WithReference(secretStore);
```

This code snippet illustrates how Preview 2 allows specifying Dapr file locations, which was a game-changer in maintaining a centralized configuration. An initial oversight of omitting the trailing slash in the path led to a frustrating error "secret store is not configured". In reviewing the logs of the Dapr sidecare revealed that the secretstore was not being loaded. Doing some debugging with the Aspire source provided the much-needed insight. Looking at the command line in the Aspire
Dashboard showed that the resources path ommited the /component part of the path.

```csharp
...
foreach (var componentReferenceAnnotation in componentReferenceAnnotations)
{
if (componentReferenceAnnotation.Component.Options?.LocalPath is not null)
{
var localPathDirectory = Path.GetDirectoryName(NormalizePath(componentReferenceAnnotation.Component.Options.LocalPath));

        if (localPathDirectory is not null)
        {
            aggregateResourcesPaths.Add(localPathDirectory);
        }
    }
    else if (onDemandResourcesPaths.TryGetValue(componentReferenceAnnotation.Component.Name, out var onDemandResourcesPath))
    {
        string onDemandResourcesPathDirectory = Path.GetDirectoryName(onDemandResourcesPath)!;

        if (onDemandResourcesPathDirectory is not null)
        {
            aggregateResourcesPaths.Add(onDemandResourcesPathDirectory);
        }
    }

}
...
```

I'm currently developing a simplified version of these projects to experiment with new ideas before integrating them into production projects. You're welcome to check out the progress and contribute your insights on my personal [GitHub repository](https://github.com/gabrewer/gabMileage).

My journey with Dapr and .NET Aspire continues to be a learning curve. I'm excited to see how these tools evolve and how they can further enhance SaaS project development.
