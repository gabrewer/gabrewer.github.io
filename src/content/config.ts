import { defineCollection, z } from 'astro:content';

// Flexible tags: string or array of strings (11ty posts used both formats)
const tagsSchema = z.union([
  z.string().transform((s) => [s]),
  z.array(z.string()),
]).optional();

// Flexible categories: string or array of strings
const categoriesSchema = z.union([
  z.string().transform((s) => [s]),
  z.array(z.string()),
]).optional();

const blogSchema = z.object({
  title: z.string(),
  date: z.coerce.date(),
  author: z.string().optional(),
  comments: z.boolean().optional(),
  categories: categoriesSchema,
  tags: tagsSchema,
  description: z.string().optional(),
  permalink: z.string().optional(),
});

const blog = defineCollection({
  type: 'content',
  schema: blogSchema,
});

const links = defineCollection({
  type: 'content',
  schema: blogSchema,
});

export const collections = { blog, links };
