// Author: Anil Kulkarni
package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"time"
)

const PORT = "35001"

func main() {
	srv := http.Server{Addr: fmt.Sprintf("0.0.0.0:%s", PORT)}
	http.HandleFunc("/", func(rw http.ResponseWriter, r *http.Request) {
		if saml := r.FormValue("SAMLResponse"); saml != "" {
			rw.WriteHeader(http.StatusOK)
			rw.Write([]byte("succeeded"))
			go func() {
				time.Sleep(time.Second * 5) // Let the POST request return to the caller successfully before returning the SAML token
				fmt.Println(saml)
				ctx, onComplete := context.WithTimeout(context.Background(), time.Second*5)
				srv.Shutdown(ctx)
				onComplete()
			}()
		} else {
			rw.WriteHeader(http.StatusBadRequest)
		}
	})
	if err := srv.ListenAndServe(); err != http.ErrServerClosed {
		log.Fatalf("Error: %v\n", err)
	}
}
