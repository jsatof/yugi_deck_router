package main

import (
	"log"
	"net/http"

	"time"
)

func main() {
	mux := http.NewServeMux()

	server := http.Server{
		Addr:         ":8000",
		WriteTimeout: 5 * time.Second,
		ReadTimeout:  10 * time.Second,
		Handler:      mux,
	}

	err := server.ListenAndServe()
	if err != nil {
		log.Fatalf("%s\n", err)
	}
}
