<link rel="stylesheet" href="css/posts.css">
<x-layout>
    <h2>Posts</h2>
    <div>
        @foreach ($posts as $post)
            <p>{{ $post->title }}</p>
            <p class="content">{{ $post->content }}</p>
            <p>{{ $post->user->name }}</p>
        @endforeach
    </div>
</x-layout>